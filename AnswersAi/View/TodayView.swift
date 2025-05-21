//
//  TodayView.swift
//  Nishant-AnswersAi-iOS
//
//  Created by Nishant Kumar on 5/21/25.
//


import SwiftUI

struct TodayView: View {
    @StateObject private var viewModel = TodayViewModel()
    
    @State private var showDetail = false
    @State private var currentItem: LargeCardModel?
    @State private var scale: CGFloat = 1
    @State private var animateView = false
    @State private var animateContent = false
    @State private var scrollOffset: CGFloat = 0
    @State private var beginDragToCloseGesture: Bool = false
    @State private var cornerRadius: CGFloat = 0
    @State private var isAccountViewPresented = false
    
    @Namespace private var animation
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    sectionHeader(isFirstSection: true)
                    items(in: viewModel.todayItems)
                    sectionHeader()
                    items(in: viewModel.moreStories)
                }
                .overlay {
                    if let currentItem = currentItem, showDetail {
                        detailView(item: currentItem)
                            .ignoresSafeArea()
                    }
                }
                .toolbar(showDetail ? .hidden : .visible, for: .tabBar)
                .statusBarHidden(showDetail ? true : false)
            }
        }
        .onAppear {
            viewModel.loadContent()
        }
        .alert("Error", isPresented: .constant(viewModel.error != nil), actions: {
            Button("OK") {
                viewModel.error = nil
            }
        }, message: {
            if let error = viewModel.error {
                Text(error.localizedDescription)
            }
        })
    }

	@ViewBuilder
	func sectionHeader(isFirstSection: Bool = false) -> some View {
		Group {
			if isFirstSection {
				VStack(alignment: .leading) {
					Text(Date().toFullDateFormat().uppercased())
						.font(.footnote.weight(.semibold))
						.foregroundColor(.secondary)

					HStack(spacing: 0) {
						Text(Date().toWeekDayFormat())
							.font(.largeTitle.weight(.bold))
						Spacer()
						AccountButton(isAccountViewPresented: $isAccountViewPresented)
					}
					.opacity(showDetail ? 0 : 1)
				}
			} else {
				VStack(alignment: .leading) {
					Divider ()
					Text("More Stories For You")
						.font(.title.weight(.bold))
				}
			}
		}
		.padding(.top)
		.padding(.horizontal, 20)
	}

	@ViewBuilder
	func items(in array: [LargeCardModel]) -> some View {
		ForEach (array) { item in
			Button {
				withAnimation(.largeCardDetail) {
					currentItem = item
					showDetail = true
				}
			} label: {
				cardView(item: item)
			}
			.buttonStyle(.scaleButtonStyle)
			.padding(.bottom)
			.padding(.horizontal, 20)
		}
	}

	// MARK: - Card View

	@ViewBuilder
	func cardView(item: LargeCardModel) -> some View {
		VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Image(item.artwork)
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fill)
                
                VStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(item.platformTitle.uppercased())
                            .foregroundColor(.secondary)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(item.bannerTitle)
                            .font(.title.weight(.bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if let subTitle = item.platformSubTitle {
                            Text(subTitle)
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.horizontal, 20)
                                        
                    AppSmallCard(item: item, titleColor: .white, subtitleColor: .white, buttonDescriptionColor: .white, imageSize: 48)
                        .padding(.horizontal, 20)
                        .padding(.vertical)
                        .background(.ultraThinMaterial)
                }
            }
		}
		.background(.gray)
		.clipShape(RoundedRectangle(cornerRadius: showDetail ? 0 : 16, style: .continuous))
		.shadow(radius: showDetail ? 0 : 12, x: showDetail ? 0 : 8, y: showDetail ? 0 : 8)
		.matchedGeometryEffect(id: item.id, in: animation)
	}

	// MARK: - Detail View

	@ViewBuilder
	func detailView(item: LargeCardModel) -> some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack {
				cardView(item: item)

				VStack(spacing: 16) {
					Text(item.placeholderText)
						.foregroundColor(.secondary)
						.font(.title3)
						.lineSpacing(6)
						.padding(.bottom, 24)

					Divider()

					SecondaryButton(title: "Share Story", systemImageName: "square.and.arrow.up")
						.padding(72)
				}
				.padding(.top)
				.padding(.horizontal, 20)
				.offset(y: scrollOffset > 0 ? scrollOffset : 0)
				.opacity(animateContent ? 1 : 0)
				.scaleEffect(animateView ? 1 : 0, anchor: .top)
			}
			.offset(y: scrollOffset > 0 && scale == 1 ? -scrollOffset : 0)
			.background(Color(.systemBackground))
			.scrollOffset(offset: $scrollOffset)
		}
		.cornerRadius(cornerRadius)
		.coordinateSpace(name: "SCROLL")

		.overlay(alignment: .topTrailing) {
			Button {
				withAnimation(.largeCardDetail) {
					resetAnimations()
				}
			} label: {
				Image(systemName: "xmark.circle.fill")
					.font(.largeTitle)
					.imageScale(.small)
                    .foregroundStyle(Color(.gray).opacity(0.8), Color(.white).opacity(0.5))
					.opacity(scale - cornerRadius)

			}
			.padding(.top, 20)
			.padding(.horizontal, 20)
		}
		.onAppear {
			withAnimation(.largeCardDetail) {
				animateView = true
			}
			withAnimation {
				animateContent = true
			}
		}
		.transition(.identity)
		.scaleEffect(scale)
		.background(.ultraThinMaterial.opacity(scale == 1 ? 0 : 1))
		.background(scale == 1 ? Color(.systemBackground) : .clear)
		.onChange(of: scrollOffset) { _ ,newValue in
			guard newValue <= 0, !beginDragToCloseGesture else {
				beginDragToCloseGesture = true
				return
			}
			beginDragToCloseGesture = false
		}
		.gesture(beginDragToCloseGesture ? DragGesture(minimumDistance: 0).onChanged(onChanged(value:)).onEnded(onEnded(value:)) : nil)
	}

	func onChanged(value: DragGesture.Value) {
		beginDragToCloseGesture = true
		let scale = value.translation.height / UIScreen.main.bounds.height
		guard 1 - scale <= 1, showDetail else { return }
		cornerRadius = value.translation.height - value.translation.height / 1.2

		if 1 - scale < 0.84 {
			withAnimation(.largeCardDetail) {
				resetAnimations()
			}
		} else if 1 - scale > 0.84 {
			self.scale = 1 - scale
		}
	}

	func onEnded(value: DragGesture.Value) {
		withAnimation(.largeCardDetail) {
			scale = 1
			cornerRadius = 0
			beginDragToCloseGesture = false
		}
	}

	func resetAnimations() {
		currentItem = nil
		showDetail = false
		animateView = false
		animateContent = false
		scale = 1
		beginDragToCloseGesture = false
		cornerRadius = 0
	}
}

#Preview {
    TodayView()
}

