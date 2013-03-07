class NetworkController < ApplicationController


  def grepPing (nmapOutput)
    sLine = nmapOutput.grep(/Host is up/)
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
    sLine.slice! "\n"
    return sLine
  end

  def grepStatus (nmapOutput, ip)
    if
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
    sLine = nmapOutput.grep(/MAC Address/)
    sedRegex = [
      's/^.*Address: //g',
      's/s (.*$//g'
    ]
    sLine = `echo '#{sLine}' |sed '#{sedRegex[0]}' |sed '#{sedRegex[1]}' |cut -c 1-17 `
    sLine.slice! "\n"
    return sLine
  end

  def getBrand (nmapOutput)
    sLine = nmapOutput.grep(/MAC Address/)
    sedRegex = [
      's/^.*Address: //g',
      's/s (.*$//g'
    ]
    sLine = `echo '#{sLine}' |sed '#{sedRegex[0]}' |sed '#{sedRegex[1]}' |cut -c 19- `
    sLine.slice! "("
    sLine.slice! ")\"]"
    sLine.slice! "\n"
    return sLine
  end

  def getHostStatus (ip)

    sOutput = `sudo nmap -sP #{ip}`
    aOutput = sOutput.split( /\r?\n/ )

    resp = {
      :ip       => ip,
      :hostname => self.grepHostname(ip),
      :mac      => self.grepMAC(aOutput),
      :ping     => self.grepPing(aOutput),
      :status   => self.grepStatus(aOutput, ip),
      :brand    => self.getBrand(aOutput)
    }
    return resp
  end

  def sylab
  end

  def scan
    @ip = self.getHostStatus(params[:ip])
    render :json => @ip
  end
end
