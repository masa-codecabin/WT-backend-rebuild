require "net/http"

top_level = self

using Module.new {
  refine(top_level.singleton_class) do
    def url_exist?(url_string)
      url = URI.parse(url_string)
      req = Net::HTTP.new(url.host, url.port)
      req.use_ssl = (url.scheme == 'https')
      path = url.path if url.path.present?
      res = req.request_head(path || '/')
      if res.kind_of?(Net::HTTPRedirection)
        url_exist?(res['location']) # Go after any redirect and make sure you can access the redirected URL
      else
        res.code[0] != "4" #false if http code starts with 4 - error on your side.
      end
    rescue StandardError
      false #false if can't find the server
    end
  end
}

namespace :monitoring_task do
  desc "Verify the url response is 200 or not."

  task verify_every_10minutes: :environment do
    MonitoringSetting.where(verification_timing: "10minutes").each do |m|
      if url_exist?(m.url)
        Attempt.create!(
          status: "ok",
          monitoring_setting_id: m.id,
        )
      else
        Attempt.create!(
          status: "fales",
          monitoring_setting_id: m.id,
        )
        user =　User.find(params[:id])
        FailureNoticeMailer.send_failure_notice(m.url, user.email).deliver
      end
   end
  end

  task verify_every_hour: :environment do
    MonitoringSetting.where(verification_timing: "hour").each do |m|
      if url_exist?(m.url)
        Attempt.create!(
          status: "ok",
          monitoring_setting_id: m.id,
        )
      else
        Attempt.create!(
          status: "fales",
          monitoring_setting_id: m.id,
        )
        user =　User.find(params[:id])
        FailureNoticeMailer.send_failure_notice(m.url, user.email).deliver
      end
   end
  end

  task verify_every_3hours: :environment do
    MonitoringSetting.where(verification_timing: "3hours").each do |m|
      if url_exist?(m.url)
        Attempt.create!(
          status: "ok",
          monitoring_setting_id: m.id,
        )
      else
        Attempt.create!(
          status: "fales",
          monitoring_setting_id: m.id,
        )
        user =　User.find(params[:id])
        FailureNoticeMailer.send_failure_notice(m.url, user.email).deliver
      end
   end
  end

end
