class PhotosController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_photo, only: [:show, :edit, :update, :destroy]


  #A frequent practice is to place the standard CRUD actions in each controller
  # in the following order: index, show, new, edit, create, update and destroy.
  # They must be placed before declaring private visibility in the controller.

  # Show all of the photos
  # /photos
  # /photos.json
  def index
    @photos = Photo.all
  end

  # Show the selected photo
  # /photos/1
  # /photos/1.json
  def show
    #passing in params[:id] to get the :id parameter from the request.
    #Use an instance variable (prefixed with @) to hold a reference to the article object
    #as Rails will pass all instance variables to the view.
    # @photo = Photo.find(params[:id])
    @photo = Photo.with_attached_images.find(params[:id])
  end

  # /photos/new
  def new
    # new action is now creating a new instance variable called @article
    #The reason why we added @article = Article.new is that otherwise
    # @article would be nil in our view, and calling @article.errors.any? would throw an error.
    @photo = Photo.new
  end

  # /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
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
    @photo = Photo.find(params[:id])
    #it accepts a hash containing the attributes that you want to update.
    #It is not necessary to pass all the attributes to update

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
    @photo = Photo.find(params[:id])
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_path, notice: 'Destroyed successfully.' }
      format.json { head :no_content }
    end
  end

  # DELETE /photos/all
  def all_destroy
    @photos = Photo.where(visibility: "3") #temp set
    @photos.destroy_all
    respond_to do |format|
      format.html { redirect_to photos_path, notice: 'All photos were successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # def set_photo
    #   @photo = Photo.find(params[:id])
    # end
    # define our permitted controller parameters to prevent wrongful mass assignment.
    def photo_params
      #strong parameters
      params.require(:photo).permit(:title, :description, :created_by, :visibility, images:[]).merge(created_by: current_user.email)
    end
end

