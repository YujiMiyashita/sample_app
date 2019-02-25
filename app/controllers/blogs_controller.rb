class BlogsController < ApplicationController
  # 各アクションの中身が実行される前に実行される
  # マスト引数: privateのメソッド名
  # onlyオプションをつけることで実行するアクションを制限することが可能
  # onlyの対義語は except
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  def index
    # Blogのインスタンスを全て取得し、@blogsに代入
    # SQL: select * from blogs;
    @blogs = Blog.all

    # app/view/blogs/index.html.erb が生成される
  end

  # GET /blogs/:id
  def show
    # before_action :set_blogが実行される

    # app/view/blogs/show.html.erb が生成される
  end

  # GET /blogs/new
  def new
    # Blogのインスタンスを生成し、@blogに代入
    # form_forで必要な値
    # SQLは実行されない
    @blog = Blog.new

    # app/view/blogs/new.html.erb が生成される
  end

  # GET /blogs/:id/edit
  def edit
    # before_action :set_blogが実行される

    # app/view/blogs/edit.html.erb が生成される
  end

  # POST /blogs
  def create
    # Blogのインスタンスを生成し、@blogに代入
    # このときストロングパラメータを通過したパラメータが引き継がれる
    @blog = Blog.new(blog_params)

    # SQL: insert into blogs (`title`, `content`, `created_at`, `updated_at`)
    #      values ('test', 'test', '2019-02-25 10:50:09', '2019-02-25 10:50:09');
    # saveの戻り値は true/false
    if @blog.save
      # redirect_to blog_url(@blog) の省略形
      # HTTPメソッド: GET, blog_url(@blog): /blogs/:id なので、showアクションにリダイレクト
      # noticeで指定したフラッシュメッセージは <%= notice %> に出力される
      redirect_to @blog, notice: 'Blog was successfully created.'
    else
      # データに問題があれば app/view/blogs/new.html.erb が生成される
      render :new
    end
  end

  # PATCH/PUT /blogs/:id
  def update
    # before_action :set_blogが実行される
    # ストロングパラメータを通過したパラメータで指定されたBlogのインスタンスを更新
    # SQL: update blogs set title = 'title1', updated_at = 'YYYY-mm-dd HH:MM:SS' WHERE blogs.id = X;
    if @blog.update(blog_params)
      # redirect_to blog_url(@blog) の省略形
      # HTTPメソッド: GET, blog_url(@blog): /blogs/:id なので、showアクションにリダイレクト
      # noticeで指定したフラッシュメッセージは <%= notice %> に出力される
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      # データに問題があれば app/view/blogs/edit.html.erb が生成される
      render :edit
    end
  end

  # DELETE /blogs/:id
  def destroy
    # before_action :set_blogが実行される
    # 指定されたBlogのインスタンスを削除
    # SQL: delete from blogs where blogs.id = X;
    @blog.destroy

    # HTTPメソッド: GET, blogs_url: /blogs なので、indexアクションにリダイレクト
    # noticeで指定したフラッシュメッセージは <%= notice %> に出力される
    redirect_to blogs_url, notice: 'Blog was successfully destroyed.'
  end

  # private以下はメソッド呼び出ししかできない
  # 主に処理の共通化で使う
  private

  def set_blog
    # id: X のBlogのインスタンスを取得し、@blogに代入
    # SQL: select * from blogs where blogs.id = X;
    @blog = Blog.find(params[:id])
  end

  # ストロングパラメータ
  def blog_params
    params.require(:blog).permit(:title, :content)
  end
end
