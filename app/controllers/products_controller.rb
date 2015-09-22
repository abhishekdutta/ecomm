class ProductsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@products = Product.all.order('created_at DESC').paginate(page: params[:page], per_page: 10)
	end

	def new
		@product=Product.new
	end

	def create
		@product=Product.new(product_params)
		
		if @product.save
			redirect_to @product
		else
			render 'new'
		end
	end

	def show
		@product = Product.find(params[:id])
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])

		if @product.update(params[:product].permit(:title, :body, :image))
			redirect_to @product
		else
			render 'edit'
		end	
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy

		redirect_to root_path
	end

	private
		def product_params
			params.require(:product).permit(:title, :body, :image)
		end	 
end
