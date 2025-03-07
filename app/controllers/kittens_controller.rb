class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      redirect_to root_path, notice: "Kitten Added Successfully"
    else
      flash[:alert] = "Failed to add Kitten. Please check the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      redirect_to root_path, notice: "Kitten Updated Successfully"
    else
      flash[:alert] = "Failed to update Kitten. Please check the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy
    flash[:notice] = "Kitten Deleted Successfully"
    redirect_to root_path
  end

  private

  def kitten_params
    params.expect(kitten: [ :name, :age, :cuteness, :softness ])
  end
end
