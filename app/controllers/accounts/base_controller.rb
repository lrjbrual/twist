module Accounts
  class BaseController < ApplicationController
    before_action :authenticate_user!
    #before_action :authenticate_user!, except: [:receive]
    #skip_before_action :authenticate_user!, only: [:receive]

    def current_account
      @current_account ||= Account.find_by!(subdomain: request.subdomain) 
    end
    helper_method :current_account

    def owner?
      current_account.owner == current_user
    end
    helper_method :owner?
  end
end