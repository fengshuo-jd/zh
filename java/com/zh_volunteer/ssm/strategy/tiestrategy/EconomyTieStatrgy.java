package com.zh_volunteer.ssm.strategy.tiestrategy;

public class EconomyTieStatrgy implements TieStrategy {
    @Override
    public String roleStrategy(String str) {
        return "经济管理系";
    }

    public EconomyTieStatrgy() {}
}
