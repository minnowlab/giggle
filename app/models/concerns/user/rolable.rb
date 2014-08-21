class User
  module Rolable
    extend ActiveSupport::Concern

    included do
      ROLES = %w[admin manager user]
      ROLES_CN = %w[超级管理员 管理员 用户]
      ROLES_CHECKBOX = [['admin', '超级管理员'], ['manager', '管理员'], ['user', '用户']]
    end

    def roles=(roles)
      self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
    end

    def roles
      ROLES.reject do |r|
        ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
      end
    end

    def roles_cn
      ROLES_CN.reject do |r|
        ((roles_mask.to_i || 0) & 2**ROLES_CN.index(r)).zero?
      end.join(',')
    end

    def is?(role)
      roles.include?(role.to_s)
    end

    module ClassMethods
    end
  end
end
