module VCAP::CloudController
  module Jobs
    module Runtime
      class ModelDeletion < Struct.new(:model_class, :guid)
        def perform
          logger = Steno.logger('cc.background')
          logger.info("Deleting model class '#{model_class}' with guid '#{guid}'")

          model = model_class.find(guid: guid)
          return if model.nil?
          model.destroy
        end

        def job_name_in_configuration
          :model_deletion
        end

        def max_attempts
          1
        end
      end
    end
  end
end
