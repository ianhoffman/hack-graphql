namespace Directives;

use namespace Slack\GraphQL;

final class HasRole implements \Slack\GraphQL\FieldDirective {
    public function __construct(private vec<string> $roles) {}
    public async function beforeResolve(GraphQL\IFieldDefinition $field): Awaitable<void> {
        echo "HasRole\n";
    }
}

final class LogSampled implements \Slack\GraphQL\FieldDirective {
    public function __construct(private float $frequency, private string $prefix) {}
    public async function beforeResolve(GraphQL\IFieldDefinition $field): Awaitable<void> {
        echo "LogSampled\n";
    }
}

final class TestShapeDirective implements \Slack\GraphQL\FieldDirective {
    public function __construct(private shape('foo' => int, 'bar' => string) $args, private bool $extra) {}
    public async function beforeResolve(GraphQL\IFieldDefinition $field): Awaitable<void> {
        echo "TestShapeDirective\n";
    }
}