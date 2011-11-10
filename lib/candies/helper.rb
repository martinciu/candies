module Candies
  module Helper
    def candies_image_tag(args)
      image_tag("#{Candies.url}/t.gif?#{args.to_query}", :alt => "", :width => 1, :height => 1) if Candies.url
    end
  end
end
