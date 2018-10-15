class AccountsController < ApplicationController
  def new
    @account = Account.new
    @account.build_owner
  end

  def create
    account = Account.create(account_params)
    sign_in(account.owner) # acter the account has been created it will automatically signedin
    flash[:notice] = "Your account has been created."
    redirect_to root_url(subdomain: account.subdomain) #redirect to subdomain but in flash it will not work use the session_store.rb
  end

  private

  def account_params
    params.require(:account).permit(:name, :subdomain,
      { owner_attributes: [:email, :password, :password_confirmation]}
      )
  end
end
