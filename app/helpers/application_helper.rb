module ApplicationHelper
    include Pagy::Frontend
    #Returns the full title on a per-page basis
    def full_title page_title
        base_title = "Blink Blink"
        page_title.empty?? base_title : [page_title, base_title].join(" | ")
    end
end
