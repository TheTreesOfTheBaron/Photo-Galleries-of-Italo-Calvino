class PhotosController < ApplicationController
  before_action :authenticate_user!

  #A frequent practice is to place the standard CRUD actions in each controller
  # in the following order: index, show, new, edit, create, update and destroy.
  # They must be placed before declaring private visibility in the controller.

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
      # respond_to do |format|
      #   format.html { redirect_to photo_path, notice: 'Sorry, you have no permission to edit this photo.' }
      # end
      redirect_to photo_path, notice: 'Sorry, you have no permission to edit this photo.'
    end
  end

  # POST /photos
  # POST /photos.json
  def create
    #use the Article model to save the data in the database
    #Rails models can be initialized with its respective attributes,
    #which are automatically mapped to the respective database columns
    #render plain: params[:photo].inspect
    @photo = Photo.new(photo_params)

    #That action implicitly responds to all formats, but formats can also be explicitly enumerated:
    # def index
    #   @people = Person.all
    #   respond_to :html, :js
    # end
    #
    # respond_to do |format|
    #     format.html
    #     format.js
    #     format.xml { render xml: @people }
    #
    # if the client wants HTML or JS in response to this action, just respond as we would have before,
    # but if the client wants XML, return them the list of people in XML format.
    respond_to do |format|
      #save the model in the database.
      # returns a boolean indicating whether the article was saved or not.
      if @photo.save
        format.html { redirect_to @photo, notice: 'Uploaded successfully.' }
        format.json { render :show, status: :created, location: @photo }
      else
        #The render method is used so that the @article object is passed back
        # to the new template when it is rendered. This rendering is done
        # within the same request as the form submission,
        # whereas the redirect_to will tell the browser to issue another request.
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
  def select_destroy
    # fetch checked id and find record from model
    puts " -=========="
    # puts {:checked}
    # query = "id = \"#{:checked}\""
    # #query = "created_by = \"#{current_user.email}\""
    # @photos = Photo.where(query).with_attached_images
    # checked_ids = params[:photos][:checked]
    # puts {:checked}
    # @photos = Photo.where(id: checked_ids).with_attached_images
    # @photos.destroy_all
    @photos = Photo.where(id: params[:photo_ids]).with_attached_images
    @photos.destroy_all
    # Photo.destroy(params[:photo_ids])
    respond_to do |format|
      format.html { redirect_to photos_path, notice: 'Selected photos were successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Delete all photos belong to current user
  # DELETE /photos/all
  def all_destroy
    query = "created_by = \"#{current_user.email}\""
    @photos = Photo.where(query).with_attached_images
    @photos.destroy_all
    respond_to do |format|
      format.html { redirect_to photos_path, notice: 'All photos were successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # define our permitted controller parameters to prevent wrongful mass assignment.
    def photo_params
      #strong parameters
      params.require(:photo).permit(:title, :description, :created_by, :visibility, images:[]).merge(created_by: current_user.email)
    end
end

