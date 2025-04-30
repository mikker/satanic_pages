class PagesController < ApplicationController
  include SatanicPages::Controller

  # Due to Rails' layout definition logic being very complex, it's not really easy to get
  # the automatic lookup of controller scoped layouts, hence we're explicit here.
  # layout "pages"
end
