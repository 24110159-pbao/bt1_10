package com.webst5.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "UserRoles")
public class UserRole_24110159 {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer roleId;

    @Column(length = 50)
    private String roleName;

    public Integer getRoleId() { return roleId; }
    public void setRoleId(Integer roleId) { this.roleId = roleId; }
    public String getRoleName() { return roleName; }
    public void setRoleName(String roleName) { this.roleName = roleName; }
}
