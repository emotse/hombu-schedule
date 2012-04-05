class ShihansController < ApplicationController
  def index
    @shihans = Shihan.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @shihan = Shihan.find params[:id]

    respond_to do |format|
      format.html
    end
  end

end
