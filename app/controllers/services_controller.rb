class ServicesController < InheritedResources::Base

  private

    def service_params
      params.require(:service).permit(:title, :description, :creator, :service_image, :service_link)
    end
end

