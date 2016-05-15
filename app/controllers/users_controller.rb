class UsersController < ApplicationController
	def index
	end
	def create
		user = User.new(user_params)
		if user.valid? == true
			user.save
			session[:user_id] = user.id
			redirect_to "/users/%d" % user.id
		else
			flash[:errors] = user.errors.full_messages
			redirect_to "/"
		end
	end
	def log_in
		 user = User.find_by(email: params["user"][:email])
		if user && user.authenticate(params["user"][:password])
			session[:user_id]= user.id
			session[:user_name] = user.first_name
			redirect_to "/users/%d" % user.id
		else
			flash[:error] = "Invalid"
			redirect_to "/"
		end
	end
	def show
		@user = User.find(session[:user_id])
		# show shoes current user has for sale
		@user_shoes = @user.shoes.where(sold: false)
		# show shoes bought by current user
		@user_purchases = User.find(session[:user_id]).sales

		@user_sales = @user.show_sold_shoes

		@total_sales = @user_sales.sum("price")
		@total_purchases = @user_purchases.sum("amount")	

	end
	def shoes
		# gets current user
		@user = User.find(session[:user_id])
		# get all shoes for sale with ability to get seller name
		@shoes = Shoe.select("shoes.id, shoes.product, shoes.price, shoes.created_at, users.first_name, users.last_name").joins(:user).where(sold: false)
	end
	def sell
		# inserts shoe into shoe database that current user adds / redirects to show page
		Shoe.create(product:params[:product], user: User.find(session[:user_id]), price: params[:price])
		redirect_to "/users/%d" % session[:user_id]
	end
	def destroy
		# allows user to remove his shoe from shoe database / redirects to show page
		Shoe.find(params[:id]).destroy
		redirect_to "/users/%d" % session[:user_id]
	end
	def buy
	
		@shoe = Shoe.find(params[:id])
		# sale = shoe_id + buyer_id(session[:user_id])
		Sale.create(shoe: Shoe.find(params[:id]), user: User.find(session[:user_id]), amount: @shoe.price )
		# update shoe table to show sold
		Shoe.find(params[:id]).update_attribute(:sold, true)
		# send to current user dashboard
		redirect_to "/users/%d" % session[:user_id]
	end
	def log_out
		# logs current user out, clears session / redirects to log in page
		session.clear
		redirect_to "/"
	end
	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end
	
end



