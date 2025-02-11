class OrganizationPolicy < ApplicationPolicy
  def create?
    !user.suspended?
  end

  def update?
    user.org_admin?(record)
  end

  def destroy?
    user.org_admin?(record) && record.destroyable?
  end

  def leave_org?
    part_of_org?
  end

  def part_of_org?
    return false if record.blank?

    user.org_member?(record)
  end

  def admin_of_org?
    return false if record.blank?

    user.org_admin?(record)
  end

  alias generate_new_secret? update?
end
