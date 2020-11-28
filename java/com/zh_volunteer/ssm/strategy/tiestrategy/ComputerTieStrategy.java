package com.zh_volunteer.ssm.strategy.tiestrategy;

public class ComputerTieStrategy implements TieStrategy {
    @Override
    public String roleStrategy(String str) {
        return "计算机工程系";
    }

    public ComputerTieStrategy() {}
}
