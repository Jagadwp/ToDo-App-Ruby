# frozen_string_literal: true

TodoApp::App.controllers :categories do
  # map: '/categories' instead of default '/categories/index'
  get :index, map: '/categories' do
    @categories = Category.alphabetical
    render 'categories/index'
  end

  get :new, map: '/categories/new' do
    @category = Category.new
    render 'categories/new'
  end

  post :create, map: '/categories' do
    @category = Category.new(name: params[:name].to_s.strip)

    if @category.save
      flash[:success] = 'Category created!'
      redirect url(:categories, :index)
    else
      flash[:error] = @category.errors.full_messages.join(', ')
      redirect url(:categories, :new)
    end
  end

  delete :destroy, map: '/categories/:id' do
    @category = Category.find(params[:id])
    @category.destroy
    flash[:success] = 'Category deleted!'
    redirect url(:categories, :index)
  end
end
