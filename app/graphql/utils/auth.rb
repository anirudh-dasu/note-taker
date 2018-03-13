module Utils
  module Auth
    def self.protect(resolve)
      lambda do |obj, args, ctx|
        if ctx[:current_user]
          resolve.call(obj, args, ctx)
        else
          FieldError.error('user', 'You need to sign in or sign up before continuing')
        end
      end
    end
  end
end
