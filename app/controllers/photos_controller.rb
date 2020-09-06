class PhotosController < ApplicationController
  before_action :authenticate_user!

  # Show all photos of the current user and photos are publicly visible
  # /photos
  # /photos.json
  def index
    query_current_user = "created_by = \"#{current_user.email}\""
    query_public = "created_by != \"#{current_user.email}\" AND visibility = 'public'"

    # Use the built-in with_attached_images scope to avoid N+1 queries
    @photos_current_user = Photo.where(query_current_user).with_attached_images
    @photos_public = Photo.where(query_public).with_attached_images
  end

  # Show the selected photos
  # /photos/1
  # /photos/1.json
  def show
    begin
      query = "created_by = \"#{current_user.email}\" OR visibility = 'public'"
      @photo = Photo.where(query).with_attached_images.find(params[:id])
      @user_current = current_user.email

      #/photos/1: when 1 doesn't belong to the current user and is private
    rescue StandardError => e
      redirect_to photos_path, notice: 'Sorry, you have no permission to view this photo.'
    end
  end

  # /photos/new
  def new
    @photo = Photo.new
  end

  # /photos/1/edit
  def edit
    begin
      query = "created_by = \"#{current_user.email}\""
      @photo = Photo.where(query).with_attached_images.find(params[:id])

      #/photos/1/edit: when 1 doesn't belong to the current user
    rescue StandardError => e
      redirect_to photo_path, notice: 'Sorry, you have no permission to edit this photo.'
    end
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Uploaded successfully.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    query = "created_by = \"#{current_user.email}\""
    @photo = Photo.where(query).with_attached_images.find(params[:id])

    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Updated successfully.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    query = "created_by = \"#{current_user.email}\""
    @photo = Photo.where(query).with_attached_images.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_path, notice: 'Destroyed successfully.' }
      format.json { head :no_content }
    end
  end



  # Delete selected photos belong to current user
  # DELETE /photos/all
  def destroy_multiple
    @photos = Photo.where(id: params[:photo_ids]).with_attached_images
    @photos.destroy_all
    respond_to do |format|
      format.html { redirect_to photos_path, notice: 'Selected photos were successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # # Delete all photos belong to current user
  # # DELETE /photos/all
  # def all_destroy
  #   query = "created_by = \"#{current_user.email}\""
  #   @photos = Photo.where(query).with_attached_images
  #   @photos.destroy_all
  #   respond_to do |format|
  #     format.html { redirect_to photos_path, notice: 'All photos were successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end


  private
    # define our permitted controller parameters to prevent wrongful mass assignment.
    def photo_params
      #strong parameters
      params.require(:photo).permit(:title, :description, :created_by, :visibility, images:[]).merge(created_by: current_user.email)
    end
end

