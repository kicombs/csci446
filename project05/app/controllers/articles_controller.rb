class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  before_filter :load_authors, :except => [:index, :destroy]
  def index
    @articles = Article.paginate page: params[:page], per_page: 10

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    session[:last_article_page] = request.env['HTTP_REFERER'] || @article
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])
    @article.count +=1

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { 
	   if session[:last_article_page]
	     redirect_to (session[:last_article_page]), notice: 'Article was successfully updated'
          end}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  def flash_redirect(msg, *params)
    flash[:notice] = msg
    redirect_to(*params)
  end

  def store_location
    session[:return_to] = @article
  end

  def redirect_back_or(articles_path)
    redirect_to(session[:return_to] || articles_path)
    clear_return_to
  end
private
  def load_authors
    Author.all
  end

end
