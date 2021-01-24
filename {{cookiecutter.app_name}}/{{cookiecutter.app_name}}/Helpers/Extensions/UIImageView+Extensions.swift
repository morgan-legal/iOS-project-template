//
//  UIImageView+Extensions.swift
//  Stylee
//
//  Created by Morgan Le Gal on 11/06/2020.
//  Copyright © 2020 MadSeven. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    
    func setImage(
        url: URL?,
        downsamplingSize: CGSize? = nil,
        placeholder: UIImage? = R.image.placeholderImages()
    ) {
        guard let url = url else { return }
        
        let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        
        var options: KingfisherOptionsInfo = [.transition(.fade(0.4)),
                                              .scaleFactor(UIScreen.main.scale),
                                              .cacheOriginalImage]
        
        if let downsamplingSize = downsamplingSize {
            options.append(.processor(DownsamplingImageProcessor(size: downsamplingSize)))
        }
            
        kf.setImage(with: resource,
                    placeholder: placeholder,
                    options: options)
    }
    
    
    func setImage(
        url: URL?,
        referenceSize: CGSize,
        mode: Kingfisher.ContentMode? = .aspectFit,
        cornerRadius: CGFloat
    ) {
        guard let url = url else { return }
        
        let resource = ImageResource(downloadURL: url, cacheKey: "\(url.absoluteString)-resized")
        
        let imageProcessor = ResizingImageProcessor(referenceSize: referenceSize, mode: mode ?? .aspectFit)
                            |> RoundCornerImageProcessor(cornerRadius: cornerRadius)
        
        let options: KingfisherOptionsInfo = [.processor(imageProcessor),
                                              .transition(.fade(1)),
                                              .scaleFactor(UIScreen.main.scale),
                                              .cacheSerializer(FormatIndicatedCacheSerializer.png),
                                              .cacheOriginalImage]
        
        // swiftlint:disable:next force_unwrapping
        let modifiedPlaceholderImage = imageProcessor.process(item: .image(R.image.placeholderImages()!),
                                                              options: KingfisherParsedOptionsInfo(options))
        
        kf.setImage(with: resource,
                    placeholder: modifiedPlaceholderImage,
                    options: options)
    }
    
    func setImage(
        url: URL?,
        referenceSize: CGSize,
        mode: Kingfisher.ContentMode? = .aspectFit,
        cornerRadius: CGFloat,
        renderingMode: UIImage.RenderingMode = .alwaysOriginal
    ) {
        guard let url = url else { return }
        
        let resource = ImageResource(downloadURL: url, cacheKey: "\(url.absoluteString)-resized")
        
        let imageProcessor = ResizingImageProcessor(referenceSize: referenceSize, mode: mode ?? .aspectFit)
                            |> RoundCornerImageProcessor(cornerRadius: cornerRadius)
        
        let options: KingfisherOptionsInfo = [.processor(imageProcessor),
                                              .transition(.fade(1)),
                                              .scaleFactor(UIScreen.main.scale),
                                              .cacheSerializer(FormatIndicatedCacheSerializer.png),
                                              .cacheOriginalImage]
        
        // swiftlint:disable:next force_unwrapping
        let modifiedPlaceholderImage = imageProcessor.process(item: .image(R.image.placeholderImages()!),
                                                              options: KingfisherParsedOptionsInfo(options))
        
        kf.setImage(with: resource,
                    placeholder: modifiedPlaceholderImage,
                    options: options,
                    completionHandler: { result in
            switch result {
            case let .success(value):
                self.image = value.image.withRenderingMode(renderingMode)
            case let .failure(error):
                log.error("Error while fetching image with URL \(url). Error : \(error)")
            }
        })
    }
    
    func setImage(
        url: URL?,
        referenceSize: CGSize,
        mode: Kingfisher.ContentMode? = .aspectFit
    ) {
        setImage(url: url, referenceSize: referenceSize, mode: mode ?? .aspectFit, cornerRadius: .zero)
    }
    
}
