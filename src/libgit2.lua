local common = require "core.common"
local config = require "core.config"
local native = "plugins.libgit2.native"

local libgit2 = common.merge({}, native)

local ssl_certs = config.plugins.libgit2.ssl_certs
if ssl_certs then
  if ssl_certs == "noverify" then
    libgit2.certs("noverify")
  else
    local stat = system.get_file_info(ssl_certs)
    if not stat then error("can't find " .. ssl_certs) end
    libgit2.certs(stat.type, ssl_certs)
  end
else
  local paths = { -- https://serverfault.com/questions/62496/ssl-certificate-location-on-unix-linux#comment1155804_62500
    "/etc/ssl/certs/ca-certificates.crt",                -- Debian/Ubuntu/Gentoo etc.
    "/etc/pki/tls/certs/ca-bundle.crt",                  -- Fedora/RHEL 6
    "/etc/ssl/ca-bundle.pem",                            -- OpenSUSE
    "/etc/pki/tls/cacert.pem",                           -- OpenELEC
    "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem", -- CentOS/RHEL 7
    "/etc/ssl/cert.pem",                                 -- Alpine Linux (and Mac OSX)
    "/etc/ssl/certs",                                    -- SLES10/SLES11, https://golang.org/issue/12139
    "/system/etc/security/cacerts",                      -- Android
    "/usr/local/share/certs",                            -- FreeBSD
    "/etc/pki/tls/certs",                                -- Fedora/RHEL
    "/etc/openssl/certs",                                -- NetBSD
    "/var/ssl/certs",                                    -- AIX
  }
  if PLATFORM == "windows" then
    libgit2.certs("system", USERDIR .. PATHSEP .. "certs.crt")
  else
    for i, path in ipairs(paths) do
      local stat = system.get_file_info(path)
      if stat then
        libgit2.certs(stat.type, path)
        break
      end
    end
    if not has_certs then error("can't autodetect your system's SSL ceritficates; please specify specify a certificate bundle or certificate directory with config.plugins.libgit2.ssl_certs") end
  end
end

return libgit2
