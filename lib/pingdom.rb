$: << File.dirname(__FILE__)
require 'PingdomAPIDriver'

class Pingdom
  def initialize(username, password, api_key)
    @username = username
    @password = password
    @api_key  = api_key

    @driver = PingdomAPISoapPort.new
  end

  def enable_debugging
    @driver.wiredump_dev = STDERR
  end

  def session
    return @session if @session

    # no session yet -- gotta log in
    creds = Auth_CredentialsData.new
    creds.username = @username
    creds.password = @password

    result = @driver.auth_login(@api_key, creds)
		check_result(result)

    # if we got this far, we logged in ok.
    @session = result.sessionId
    return @session
  end

  def downtimes(check, from, to)
    request            = Report_GetDowntimesRequest.new
    request.checkName  = check
    request.from       = from
    request.to         = to
    request.resolution = Report_ResolutionEnum::DAILY

    result = @driver.report_getDowntimes(@api_key, session, request)
		check_result(result)

    return result.downtimesArray
  end

	class PingdomException        < RuntimeError     ; end
	class ArgumentException       < PingdomException ; end
	class InternalErrorException  < PingdomException ; end
	class IdentifcationException  < PingdomException ; end
	class AuthorizationException  < PingdomException ; end
	class AuthenticationException < PingdomException ; end

	def check_result(result)
		case result.status
		when 0: return
		when 1: raise PingdomException.new(         "Something strange happened (1)")
		when 2: raise PingdomException.new(         "Something strange happened (2)")
		when 3: raise ArgumentException.new(        "One or more arguments was invalid")
		when 4: raise InternalErrorException.new(   "Pingdom reported an internal error")
		when 5: raise IdenficationException.new(    "Wrong Identification: your API key is wrong")
		when 6: raise AuthorizationException.new(   "Wrong Authorization: you don't have the privileges to call this function")
		when 7: raise AuthenticationException.new(  "Wrong Authentication: your username or password is wrong.")
		end
	end

	def date(obj)
    case obj
    when DateTime: return obj
    when String:   return DateTime.parse(obj)
    when :now:     return DateTime.now
    else           raise  "Not sure how to turn #{obj} into a DateTime."
    end
	end
end