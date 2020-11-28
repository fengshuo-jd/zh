package com.zh_volunteer.ssm.strategy.tiestrategy;

public class EletrictInfoStrategy implements TieStrategy {
    @Override
    public String roleStrategy(String str) {
        return "电子信息工程系";
    }

    public EletrictInfoStrategy() {
    }
}
