require "formula"

class Flocker < Formula
  homepage "https://clusterhq.com"
  url "https://storage.googleapis.com/archive.clusterhq.com/downloads/flocker/Flocker-0.1.1.tar.gz"
  sha1 "fefe853683c717660d7437fa78ab85b032875c38"

  depends_on :python if MacOS.version <= :snow_leopard

  def install
    ENV.prepend_create_path "PYTHONPATH", lib/"python2.7/site-packages"

    system "python", "setup.py", "install",
           "--prefix=#{prefix}",
           "--install-scripts=#{bin}",
           "--install-data=#{libexec}"
    bin.env_script_all_files(libexec+"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "#{bin}/flocker-deploy", "--version"
  end
end
