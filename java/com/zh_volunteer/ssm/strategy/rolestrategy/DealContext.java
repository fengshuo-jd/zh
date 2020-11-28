package com.zh_volunteer.ssm.strategy.rolestrategy;

public class DealContext {
    private String type;
    private RoleStrategy roleStrategy;

    public DealContext(String type, RoleStrategy roleStrategy) {
        this.type = type;
        this.roleStrategy = roleStrategy;
    }

    public RoleStrategy getRoleStrategy() {
        return roleStrategy;
    }
    public boolean options(String type){
        return this.type.equals(type);
    }
}
