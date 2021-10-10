class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = current_user
    @booknew = Book.new
    @post_comment = PostComment.new
    impressionist(@book, nil, unique: [:ip_address])
  end

  def index
    @book = Book.new
    @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.includes(:favorites).where(created_at: Time.current.all_week).size <=> a.favorited_users.includes(:favorites).where(created_at: Time.current.all_week).size}

    # Book.includes(:favorited_users).where(created_at: Time.current.all_week).group(:id).order("count(*) desc")
    # Book.joins(:favorites).where(favorites: { created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
    # Book.joins(:favorites).where(favorites: { created_at: 0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
    # Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    # @all_ranks = Book.find(Favorite.group(:book_id).order('count(book_id) desc').limit(10),pluck(:book_id))
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to "/books"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end

end
