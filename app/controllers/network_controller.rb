class NetworkController < ApplicationController

  def grepIP (nmapOutput)
   sLine = nmapOutput
    sedRegex = [
      's/^.*report for//g',
      's/^.*edu.tw//g',
    ]
    sLine = `echo '#{sLine}' |sed '#{sedRegex[0]}' |sed '#{sedRegex[1]}' `
    sLine.slice! "\n"
    sLine.slice! ")"
    sLine.slice! "("
    sLine.slice! " "
    return sLine
  end

  def grepPing (nmapOutput)
    #sLine = nmapOutput.grep(/Host is up/)
    sLine = nmapOutput
    sedRegex = [
      's/^.*Host is up (//g',
      's/s latenc.*$//g'
    ]
    sLine = `echo '#{sLine}' |sed '#{sedRegex[0]}' |sed '#{sedRegex[1]}' `
    sLine.slice! "\n"
    return sLine
  end

  def grepHostname (ip)
    # sLine = nmapOutput.grep(/Nmap scan report for/)
    # sedRegex = [
    #   's/^.*scan report for //g',
    # ]
    # sLine = `echo '#{sLine}' |sed '#{sedRegex[0]}'' `
    # sLine.slice! "\n"
    # return sLine
    sOutput = `sudo nslookup #{ip}`
    aOutput = sOutput.split( /\r?\n/ )
    sLine = aOutput.grep(/name =/)
    sedRegex = [
      's/^.*name = //g',
    ]
    sLine = `echo '#{sLine}' |sed '#{sedRegex[0]}'  `
    sLine.slice! ".sylab.ee.ntu.edu.tw.\"]"
    sLine.slice! ".ee.ntu.edu.tw.\"]"
    sLine.slice! ".ntu.edu.tw.\"]"
    sLine.slice! "\n"
    return sLine
  end

  def grepStatus (nmapOutput, ip)
    sLine = nmapOutput
    #sLine = nmapOutput.grep(/Host is up/)
    if sLine.blank?
      sOutput = `sudo nmap -PN #{ip}`
      aOutput = sOutput.split( /\r?\n/ )
      aLine = aOutput.grep(/Nmap done: 1 IP address/)
      if aLine[0].include? '0 hosts up'
        return 'offline'
      else
        return 'online'
      end
    end
    return 'online'
  end

  def grepMAC (nmapOutput)
    #sLine = nmapOutput.grep(/MAC Address/)
    sLine = nmapOutput
    sedRegex = [
      's/^.*Address: //g',
      's/s (.*$//g'
    ]
    sLine = `echo '#{sLine}' |sed '#{sedRegex[0]}' |sed '#{sedRegex[1]}' |cut -c 1-17 `
    sLine.slice! "\n"
    return sLine
  end

  def grepBrand (nmapOutput)
    #sLine = nmapOutput.grep(/MAC Address/)
    sLine = nmapOutput
    sedRegex = [
      's/^.*Address: //g',
      's/s (.*$//g'
    ]
    sLine = `echo '#{sLine}' |sed '#{sedRegex[0]}' |sed '#{sedRegex[1]}' |cut -c 19- `
    sLine.slice! "("
    sLine.slice! "\"]"
    sLine.slice! "\n"
    sLine.slice! ")"
    return sLine
  end

  def getHostStatus (net)
    sOutput = `sudo nmap -sP #{net} --exclude 192.168.67.8 140.112.42.254 140.112.42.1`
    aOutput = sOutput.split( /\r?\n/ )
    hosts = aOutput[2..-3]
    resp = []

    # find keys is head
    heads = []
    (0..hosts.length).each do |x|
      if hosts[x]
        if hosts[x].include? 'Nmap scan report for'
          heads.push x
        end
      end
    end

    (heads).each do |x|
      ip = self.grepIP(hosts[x])
      info = {
        :ip       => ip,
        :hostname => self.grepHostname(ip),
        :mac      => self.grepMAC(hosts[x+2]),
        :ping     => self.grepPing(hosts[x+1]),
        :status   => self.grepStatus(hosts[x+1],ip),
        :brand    => self.grepBrand(hosts[x+2]),
      }
      # host = {ip => info}
      resp.push info
    end

    return resp
  end

  def sylab
  end

  def scan

    if (params[:ip][0..9] == ('140.112.42')) || (params[:ip][0..9] == ('192.168.67'))
      net_sp = params[:ip].split('.')
      net = net_sp[0] + '.' + net_sp[1] + '.' + net_sp[2] + '.0/24'

      respond_to do |format|
        format.html
        format.json do
          hosts = getHostStatus net
          render :json => hosts
        end
      end
    end
  end


  def snipet
  end

  def ee
  end
end