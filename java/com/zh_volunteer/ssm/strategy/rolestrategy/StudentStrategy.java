package com.zh_volunteer.ssm.strategy.rolestrategy;

public class StudentStrategy implements RoleStrategy {
    @Override
    public String roleStrategy(String str) {
        return "学生";
    }

    public StudentStrategy() {
    }
}
