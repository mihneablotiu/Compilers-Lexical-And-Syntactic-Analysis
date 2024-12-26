package cool.ast.expression;

import cool.ast.ASTVisitor;
import cool.ast.type.TypeId;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.Token;

public class New extends Expression {
    private final TypeId typeId;

    public New(Token token, ParserRuleContext parserRuleContext, TypeId typeId) {
        super(token, parserRuleContext);
        this.typeId = typeId;
    }

    public TypeId getTypeId() {
        return typeId;
    }


    @Override
    public <T> T accept(ASTVisitor<T> visitor) {
        return visitor.visit(this);
    }
}
