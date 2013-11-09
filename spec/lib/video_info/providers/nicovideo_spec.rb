require 'spec_helper'

describe VideoInfo::Providers::Nicovideo do

  describe ".usable?" do
    subject { VideoInfo::Providers::Nicovideo.usable?(url) }

    context "with nicovideo.jp url" do
      let(:url) { 'http://www.nicovideo.jp/watch/sm2536706' }
      it { should be_true }
    end

    context "with nico.ms url" do
      let(:url) { 'http://nico.ms/sm2536706' }
      it { should be_true }
    end

    context "with other url" do
      let(:url) { 'http://google.com/video1' }
      it { should be_false }
    end
  end

  context "with video sm2536706", :vcr do
    subject { VideoInfo.new('http://www.nicovideo.jp/watch/sm2536706') }

    its(:provider)         { should eq 'Nicovideo' }
    its(:video_id)         { should eq 'sm2536706' }
    its(:url)              { should eq 'http://www.nicovideo.jp/watch/sm2536706' }
    its(:embed_url)        { should be_nil }
    its(:embed_code)       { should eq '<script type="text/javascript" src="http://ext.nicovideo.jp/thumb_watch/sm2536706"></script><noscript><a href="http://www.nicovideo.jp/watch/sm2536706">インターネット漂流番組pndTV　『誰でもできるハンガリング講座』</a></noscript>' }
    its(:title)            { should eq 'インターネット漂流番組pndTV　『誰でもできるハンガリング講座』' }
    its(:description)      { should eq '中高年の方々に人気の「ハンガリング」をわかりやすく解説  mylist/18755088' }
    its(:keywords)         { should be_nil }
    its(:duration)         { should eq 807 }
    its(:width)            { should be_nil }
    its(:height)           { should be_nil }
    its(:date)             { should eq Time.parse('2008-03-06 20:35:58 +0900', Time.now.utc) }
    its(:thumbnail_small)  { should eq 'http://tn-skr3.smilevideo.jp/smile?i=2536706' }
    its(:thumbnail_medium) { should eq 'http://tn-skr3.smilevideo.jp/smile?i=2536706' }
    its(:thumbnail_large)  { should eq 'http://tn-skr3.smilevideo.jp/smile?i=2536706' }
    its(:view_count)       { should be > 40000 }
  end

end
