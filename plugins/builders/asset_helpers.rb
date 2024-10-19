require "image_processing/vips"
require "zlib"

# If you want to use a cryptographic digest, you can uncomment following:
#
# require "digest/sha2"

class Builders::AssetHelpers < SiteBuilder
  def build
    helper :resized_image_path do |src, width: nil, height: nil|
      basename = File.basename(src, ".*")
      ext = File.extname(src)

      # Find images from the frontend directory
      frontend_path = Pathname.new(site.root_dir).join("frontend")

      image_path = frontend_path.join(src)

      # Calculate a digest based on the original image file
      #
      digest = Zlib.crc32(File.read(image_path)).to_s(16)
      #
      # It's also possible to use a cryptographically secure digest but
      # calculating it will be slower and it's not necessarily necessary for
      # this use case.
      #
      # To use SHA256, uncomment the following and remove the CRC digest line:
      #
      # digest = Digest::SHA256.file(image_path).hexdigest
      #

      # Put resized images inside the src/images/resized directory
      static_images_dir = Pathname.new(site.root_dir).join("src", "images")
      destination_dir = Pathname.new(static_images_dir).join("resized")

      # Generate the resized filename based on the original filename, digest, and dimensions
      resized_filename = "#{basename}-#{digest}-#{width}x#{height}#{ext}"
      destination_path = destination_dir.join(resized_filename)

      # Don't do any processing if the file already exists
      if !destination_path.exist?
        Bridgetown.logger.info "Resizing image: #{src} to #{width}×#{height}"

        FileUtils.mkdir_p(destination_dir)
        pipeline = ImageProcessing::Vips.source(image_path).resize_to_limit(width, height)
        pipeline.call(destination: destination_path.to_s)
      else
        Bridgetown.logger.debug "Resized image exists: #{destination_path}"
      end

      # Calculate the relative path to the resized image in the src/images folder
      resized_path = destination_path.relative_path_from(static_images_dir)

      # Make sure that Bridgetown knows about the resized image
      site.static_files << ::Bridgetown::StaticFile.new(
        site,
        site.source,
        "images",
        resized_path
      )

      # Return the path to the resized image
      "/images/#{resized_path}"
    end
  end
end
