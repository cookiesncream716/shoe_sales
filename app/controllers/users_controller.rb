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
		@shoes = @user.shoes
		@purchases = @user.purchases
		@sales = @user.sales
		
		# @total_sales = (sales.amount).collect{ |x| x+x}

	end
	def log_out
		session.clear
		redirect_to "/"
	end
	def shoes
		@user = User.find(session[:user_id])
		@shoes = Shoe.all
	end
	def sell
		Shoe.create(product:params[:product], user: User.find(session[:user_id]), price: params[:price])
		redirect_to "/users/%d" % session[:user_id]
	end
	def destroy
		Shoe.find(params[:id]).destroy
		redirect_to "/users/%d" % session[:user_id]
	end
	def buy
		@shoe = Shoe.find(params[:id])
		seller = @shoe.user_id
		Sale.create(shoe: Shoe.find(params[:id]), user: User.find(session[:user_id]), amount: @shoe.price )
		Purchase.create(shoe: Shoe.find(params[:id]), user: params[:seller], amount: @shoe.price)
		@shoe.destroy
		redirect_to "/users/%d" % session[:user_id]
	end
	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end
	
end



