class ClassesController < ApplicationController

  def index
    @classes = Class.all
  end

  def new
    @class = Class.new
  end
  
end