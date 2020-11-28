package com.zh_volunteer.ssm.strategy.rolestrategy;

public class ManagerStrategy implements RoleStrategy {
    @Override
    public String roleStrategy(String str) {
        return "活动管理员";
    }

    public ManagerStrategy() {
    }
}
