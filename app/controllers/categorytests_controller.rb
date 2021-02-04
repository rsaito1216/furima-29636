class CategorytestsController < ApplicationController

  def index
    @categorys = Categorytest.all.order("id ASC")
    @parents =  Categorytest.where(ancestry: nil)
    # @lady_childrens =  @parents.children
    # @lady_grand_childrens = Categorytest.where(lady.children)
  end

  def show
    @categorys = Categorytest.all.order("id ASC")
    @parents =  Categorytest.where(ancestry: nil)
  end
end
