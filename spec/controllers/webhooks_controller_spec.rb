require 'spec_helper'

describe WebhooksController do

  def valid_attributes
    { "username" => "DrBlinken" }
  end

  def valid_session
    {}
  end

  def payload
     payload = <<DELIM
     {"id":4291240,"repository":{"id":366890,"name":"WebHooksPlayground","owner_name":"bkleinen","url":"https://github.com/bkleinen/WebHooksPlayground"},"number":"11","config":{"language":"ruby","rvm":["1.9.3"],"env":["DB=sqlite"],"script":["RAILS_ENV=test bundle exec rake --trace db:schema:load","RAILS_ENV=test bundle exec rspec spec"],"notifications":{"webhooks":["http://visualstats.herokuapp.com/bkleinen/WebHooksPlayground/notify"]},".result":"configured"},"status":0,"result":0,"status_message":"Fixed","result_message":"Fixed","started_at":"2013-01-21T21:14:39Z","finished_at":"2013-01-21T21:15:42Z","duration":63,"build_url":"https://travis-ci.org/bkleinen/WebHooksPlayground/builds/4291240","commit":"a1e696e84035de9037c843f837faa88badd7c7dd","branch":"master","message":"restoring travis.yml","compare_url":"https://github.com/bkleinen/WebHooksPlayground/compare/e8ebf6466b39...a1e696e84035","committed_at":"2013-01-21T21:07:57Z","author_name":"Dr Blinken","author_email":"drblinken@gmail.com","committer_name":"Dr Blinken","committer_email":"drblinken@gmail.com","matrix":[{"id":4291241,"repository_id":366890,"parent_id":4291240,"number":"11.1","state":"finished","config":{"language":"ruby","rvm":"1.9.3","env":"DB=sqlite","script":["RAILS_ENV=test bundle exec rake --trace db:schema:load","RAILS_ENV=test bundle exec rspec spec"],"notifications":{"webhooks":["http://visualstats.herokuapp.com/bkleinen/WebHooksPlayground/notify"]},".result":"configured"},"status":0,"result":0,"commit":"a1e696e84035de9037c843f837faa88badd7c7dd","branch":"master","message":"restoring travis.yml","compare_url":"https://github.com/bkleinen/WebHooksPlayground/compare/e8ebf6466b39...a1e696e84035","committed_at":"2013-01-21T21:07:57Z","author_name":"Dr Blinken","author_email":"drblinken@gmail.com","committer_name":"Dr Blinken","committer_email":"drblinken@gmail.com","finished_at":"2013-01-21T21:15:42Z"}]}
DELIM
  end

  def notify_params
    { username: "drblinken", repository: "VisualStats", payload: payload}
  end
  describe "double check: does the payload work?" do
    it "builds a visual build" do
      visual_build = VisualBuild.create_from_json_str(payload)
      visual_build.should_not == nil
      visual_build.jobs.size.should == 1
    end
  end
  describe "notify" do
      describe "POST notify" do
         describe "with valid params" do
           it "creates a new VisualBuild" do
            pending
             expect {
               post :notify, notify_params, valid_session
             }.to change(VisualBuild, :count).by(1)
           end

           it "assigns a newly created call_back as @call_back" do
            pending
             post :notify, notify_params, valid_session
             assigns(:call_back).should be_a(CallBack)
             assigns(:call_back).should be_persisted
           end

           it "redirects to the created call_back" do
            pending
             post :notify, notify_params, valid_session
             response.should redirect_to(CallBack.last)
           end
         end


       end

  end
end
