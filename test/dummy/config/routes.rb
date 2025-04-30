Rails.application.routes.draw do
  get("up" => "rails/health#show", :as => :rails_health_check)
  get("*page", to: "pages#show", as: :page, constraints: PagesController.constraint)
  root("pages#show", page: "about")
end
