/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run vendor/bin/hacktest
 *
 *
 * @generated SignedSource<<1582877e83a595ff1ea0f2dc170c0085>>
 */
namespace Slack\GraphQL\Test\Generated;
use namespace Slack\GraphQL;
use namespace Slack\GraphQL\Types;
use namespace HH\Lib\{C, Dict};

final class __InputValue extends \Slack\GraphQL\Types\ObjectType {

  const NAME = '__InputValue';
  const type THackType = \Slack\GraphQL\Introspection\__InputValue;
  const keyset<string> FIELD_NAMES = keyset[
    'defaultValue',
    'description',
    'name',
    'type',
  ];

  public function getFieldDefinition(
    string $field_name,
  ): ?GraphQL\IResolvableFieldDefinition<this::THackType> {
    switch ($field_name) {
      case 'defaultValue':
        return new GraphQL\FieldDefinition(
          'defaultValue',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDefaultValue(),
        );
      case 'description':
        return new GraphQL\FieldDefinition(
          'description',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getDescription(),
        );
      case 'name':
        return new GraphQL\FieldDefinition(
          'name',
          Types\StringOutputType::nullable(),
          async ($parent, $args, $vars) ==> $parent->getName(),
        );
      case 'type':
        return new GraphQL\FieldDefinition(
          'type',
          __Type::nullable(),
          async ($parent, $args, $vars) ==> $parent->getType(),
        );
      default:
        return null;
    }
  }
}
