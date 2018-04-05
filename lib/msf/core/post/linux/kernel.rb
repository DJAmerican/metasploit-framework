# -*- coding: binary -*-
require 'msf/core/post/common'

module Msf
class Post
module Linux
module Kernel
  include ::Msf::Post::Common

  #
  # Returns the kernel version
  #
  # @return [String]
  #
  def kernel_version
    cmd_exec('uname -r').to_s
  rescue
    raise 'Could not determine kernel version'
  end

  #
  # Returns the kernel modules
  #
  # @return [String]
  #
  def kernel_modules
    cmd_exec('cat /proc/modules').to_s
  rescue
    raise 'Could not determine kernel modules'
  end

  #
  # Returns true if kernel and hardware supports Supervisor Mode Access Prevention (SMAP), false if not.
  #
  # @return [Boolean]
  #
  def smap_enabled?
    cmd_exec('cat /proc/cpuinfo').to_s.include? 'smap'
  rescue
    raise 'Could not determine SMAP status'
  end

  #
  # Returns true if kernel and hardware supports Supervisor Mode Execution Protection (SMEP), false if not.
  #
  # @return [Boolean]
  #
  def smep_enabled?
    cmd_exec('cat /proc/cpuinfo').to_s.include? 'smep'
  rescue
    raise 'Could not determine SMEP status'
  end

  #
  # Returns true if user namespaces are enabled, false if not.
  #
  # @return [Boolean]
  #
  def userns_enabled?
    return false if cmd_exec('cat /proc/sys/user/max_user_namespaces').to_s.eql? '0'
    cmd_exec('cat /proc/sys/kernel/unprivileged_userns_clone').to_s.eql? '1'
  rescue
    raise 'Could not determine userns status'
  end

end # Kernel
end # Linux
end # Post
end # Msf
