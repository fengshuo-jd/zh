package com.zh_volunteer.ssm.strategy.tiestrategy;

public class AutomaticTieStrategy implements TieStrategy{
    @Override
    public String roleStrategy(String str) {
        return "自动化工程系";
    }

    public AutomaticTieStrategy() {}
}
