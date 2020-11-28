package com.zh_volunteer.ssm.strategy.rolestrategy;

public class SuperStretegy implements RoleStrategy {
    @Override
    public String roleStrategy(String str) {
        return "超级管理员";
    }

    public SuperStretegy() {
    }
}

