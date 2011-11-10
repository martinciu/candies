module Tracker
  module Helper
    def tracker_image_tag(args)
      image_tag("#{Tracker.url}/t.gif?#{args.to_query}", :alt => "", :width => 1, :height => 1) if Tracker.url
    end
  end
end
