class AccountsController < ApplicationController
  def new
    @account = Account.new
    @account.build_owner
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      sign_in(@account.owner) # acter the account has been created it will automatically signedin
      flash[:notice] = "Your account has been created."
      redirect_to root_url(subdomain: @account.subdomain) #redirect to subdomain but in flash it will not work use the session_store.rb
    else
      flash.now[:alert] = "Sorry, your account could not be created."
      render :new      
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :subdomain,
      { owner_attributes: [:email, :password, :password_confirmation] }
      )
  end
end
