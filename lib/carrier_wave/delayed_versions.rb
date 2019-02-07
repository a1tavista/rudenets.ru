module CarrierWave
  module DelayedVersions
    extend ActiveSupport::Concern

    module ClassMethods
      def delayed_versions
        @delayed_versions ||= Set.new
      end

      def delayed_version(name, opts = {}, &block)
        delayed_versions.add(name)
        version(name, opts.merge(if: :processing_async?), &block)
      end
    end

    def processing_async?(_img = nil)
      !!model.processing_async
    end

    module ModelMethods
      extend ActiveSupport::Concern

      included { attr_accessor :processing_async }

      def with_async_processing
        self.processing_async = true
        yield
      ensure
        self.processing_async = false
      end

      def process_delayed_versions!
        self.class.uploaders.each do |mounted_as, uploader|
          next unless uploader.included_modules.include?(Carrierwave::DelayedVersions) &&
                      !uploader.delayed_versions.empty?

          with_async_processing do
            send(mounted_as).send(:"recreate_versions!", *uploader.delayed_versions.to_a)
          end
        end
      end
    end
  end
end
