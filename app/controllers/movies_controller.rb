class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #remember the users choices and update with the latest preferences
    session.update(params)

    #set order of the movies selected by user, use session to persist
    if params[:order] != nil
      @order = params[:order]
    else
      @order = session[:order]
    end

    #avoid an exception if empty array
    if params[:ratings] != nil
      #allows ratings to be persisted across page click on the rating sort header
      @ratings_persist = params[:ratings]
      #dont care about the value just pass me the ratings
      @ratings_sel = params[:ratings].keys
      @movies = Movie.where(:rating => @ratings_sel).order(params[:order])
    else
      #no ratings selected - ok I'll give you what you asked for before
      @ratings_persist = params[:ratings]      
      @ratings_sel = session[:ratings].keys
      @movies = Movie.where(:rating => @ratings_sel).order(params[:order])
    end  
    #select ratings for check bokes
    @all_ratings = Movie.select(:rating).map(&:rating).uniq
  end

  def new
    # default: render 'new' template
  end

  def creates
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
