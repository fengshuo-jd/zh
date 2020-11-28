package com.zh_volunteer.ssm.strategy.tiestrategy;

public class MachineTieStrategy implements TieStrategy {
    @Override
    public String roleStrategy(String str) {
        return "机械工程系";
    }

    public MachineTieStrategy() {}
}
