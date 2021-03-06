class Admin::SignaturesController < ApplicationController
  
  before_filter :require_admin
  
  respond_to :js, :only => [:display, :hide]

  def index
    @signatures = Signature.order("id DESC").paginate :per_page => 15, :page => params[:page]
  end

  def display
    @signature = Signature.find(params[:id])
    @signature.status = Signature::STATUS_NAMES[:normal]
    if @signature.save
      respond_with(@signature)
    else
      render :js => "$.jGrowl('出错了！');"
    end
  end

  def hide
    @signature = Signature.find(params[:id])
    @signature.status = Signature::STATUS_NAMES[:deleted]
    if @signature.save
      respond_with(@signature)
    else
      render :js => "$.jGrowl('出错了！');"
    end
  end
end
